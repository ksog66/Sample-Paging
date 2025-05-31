import co.touchlab.skie.configuration.FlowInterop
import co.touchlab.skie.configuration.EnumInterop
import co.touchlab.skie.configuration.SealedInterop
import co.touchlab.skie.configuration.SuspendInterop
import org.jetbrains.kotlin.gradle.dsl.JvmTarget
import java.util.Properties

plugins {
    alias(libs.plugins.kotlinMultiplatform)
    alias(libs.plugins.androidLibrary)
    alias(libs.plugins.kotlinSerialization)
    alias(libs.plugins.ksp)
    alias(libs.plugins.kmpNativeCoroutines)
    alias(libs.plugins.skie)
    alias(libs.plugins.room)
}

kotlin {
    jvmToolchain(17)
    androidTarget {
        compilations.all {
            compileTaskProvider.configure {
                compilerOptions {
                    jvmTarget.set(JvmTarget.JVM_11)
                }
            }
        }
    }

    listOf(
        iosX64(),
        iosArm64(),
        iosSimulatorArm64()
    ).forEach {
        it.binaries.framework {
            baseName = "shared"
            isStatic = true
            linkerOpts.add("-lsqlite3")
        }
    }

    sourceSets {
        all {
            languageSettings.optIn("kotlinx.cinterop.ExperimentalForeignApi")
        }
        androidMain.dependencies {
            implementation(libs.androidx.datastore)
            implementation(libs.androidx.datastore.preference)

            implementation(libs.koin.androidx.compose)
            implementation(libs.koin.android)

            implementation(libs.androidx.room.runtime.android)
        }
        commonMain.dependencies {
            implementation(libs.coroutines.core)
            //ktor
            implementation(libs.ktor.core)
            implementation(libs.ktor.contentNegotiation)
            implementation(libs.ktor.serialization)
            implementation(libs.ktor.logging)

            //paging
            implementation(libs.paging.common)

            //room
//            implementation(libs.androidx.room.ktx)
            implementation(libs.androidx.room.runtime)
            implementation(libs.androidx.room.paging)

            implementation(libs.sqlite.bundled)

            //datastore
            implementation(libs.androidx.datastore)
            implementation(libs.androidx.datastore.preference)

            //kotlinx-datetime
            implementation(libs.kotlinx.datetime)

            implementation(libs.kotlinx.serialization)
            implementation(libs.koin.core)

            implementation(libs.skie.annotations)

            //lifecycle
            implementation(libs.androidx.lifecycle.viewmodel)

            // KMP Observable ViewModel
            api(libs.kmp.observableviewmodel.core)
        }
        commonTest.dependencies {
            implementation(libs.kotlin.test)
            implementation(libs.koin.test)

            implementation(libs.mockk)
        }

        iosMain.dependencies {
            implementation(libs.ktor.darwin)
            implementation(libs.paging.ios)
            //datastore
            implementation(libs.androidx.datastore)
            implementation(libs.androidx.datastore.preference)
        }
    }
}

android {
    namespace = "com.kklabs.sharedpagination"
    compileSdk = 35
    defaultConfig {
        minSdk = 24
    }
    buildFeatures {
        buildConfig = true
    }
    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_1_8
        targetCompatibility = JavaVersion.VERSION_1_8
    }
}

skie {
    features {
        group {
            FlowInterop.Enabled(true)
            coroutinesInterop.set(true)
            SuspendInterop.Enabled(true)
            EnumInterop.Enabled(true)
            SealedInterop.Enabled(true)
        }
    }
}

kotlin.sourceSets.all {
    languageSettings.optIn("kotlin.experimental.ExperimentalObjCName")
}
dependencies {
    add("kspAndroid", libs.androidx.room.compiler)
    add("kspIosSimulatorArm64", libs.androidx.room.compiler)
    add("kspIosX64", libs.androidx.room.compiler)
    add("kspIosArm64", libs.androidx.room.compiler)
}

room {
    schemaDirectory("$projectDir/schemas")
}
